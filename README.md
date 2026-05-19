# Panz3r Tap

## Included formulae

No formulae published yet.

## How do I install these formulae?

`brew install panz3r/tap/<formula>`

Or `brew tap panz3r/tap` and then `brew install <formula>`.

Or, in a `brew bundle` `Brewfile`:

```ruby
tap "panz3r/tap"
brew "<formula>"
```

## Documentation

`brew help`, `man brew` or check [Homebrew's documentation](https://docs.brew.sh).

## Development

### Adding a new formula

Create the formula in this tap with Homebrew tooling:

```bash
brew create <SOURCE_URL> --tap panz3r/homebrew-tap --set-name <formula-name>
```

Then update the generated file under `Formula/`, commit, and push.

For unsigned binaries, include a `caveats` block to explain Gatekeeper/quarantine
handling, for example:

```ruby
def caveats
  <<~EOS
    #{if OS.mac?
        <<~MAC
          This binary is unsigned. You may need to authorize it in
          System Settings > Privacy & Security, or run:
            xattr -d com.apple.quarantine #{bin}/depsclean
        MAC
    end}
  EOS
end
```

### Auditing a new formula

Please audit and test formula before submitting:
```bash
HOMEBREW_NO_INSTALL_FROM_API=1 brew audit --new <formula-name>
HOMEBREW_NO_INSTALL_FROM_API=1 brew install --build-from-source --verbose --debug <formula-name>
HOMEBREW_NO_INSTALL_FROM_API=1 brew test <formula-name>
```

### Releasing a new formula version

When a pull request making changes to a formula (or formulae) becomes green
(all checks passed), then you can publish the built bottles.
To do so, label your PR as `pr-pull` and the workflow will be triggered.

## License

MIT License. See [LICENSE](LICENSE).