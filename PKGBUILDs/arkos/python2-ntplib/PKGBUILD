_pkgbase=ntplib
pkgname=python2-ntplib
pkgver=0.3.2
pkgrel=1
pkgdesc="a simple interface to query NTP servers from Python"
arch=('any')
url="http://pypi.python.org/pypi/ntplib"
license=("GPL2")
depends=('python2')
source=(http://pypi.python.org/packages/source/n/${_pkgbase}/${_pkgbase}-${pkgver}.tar.gz)
sha1sums=('e4106549a3697765a81aa47a5110e56d59ab068e')

build() {
  :
}

package() {
  cd "$srcdir"/${_pkgbase}-$pkgver
  python2 setup.py install --root="$pkgdir"
}
