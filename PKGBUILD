# Maintainer: onemyndseye  <onemyndseye@gmail.com>
pkgname=discord-launcher
pkgver=0.95
pkgrel=1
pkgdesc="Userland Discord updater/launcher script for Linux"
arch=('x86_64')
url="https://github.com/onemyndseye/discord-launcher"
license=('MIT')
depends=('bash' 'curl' 'wget' 'tar' 'grep' 'pkill')
provides=('discord')
conflicts=('discord')
source=("https://raw.githubusercontent.com/onemyndseye/discord-launcher/refs/heads/main/discord-launcher.sh")
sha256sums=('SKIP')  # Replace SKIP with actual hash if desired

package() {
    # Install the launcher script
    install -Dm755 discord-launcher.sh "$pkgdir/usr/bin/discord-launcher.sh"
    ln -sf /usr/bin/discord-launcher.sh /usr/bin/discord     

}

post_install() {
    cat <<EOF
Important:
Run the launcher once manually to initialize Discord:
    $ /usr/bin/discord-launcher.sh
  -or-
    $ /usr/bin/discord
This will download Discord and set up your configuration and desktop entry.

EOF
}
