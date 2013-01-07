module.exports = function flattenPkgTree(tree){
  var pkgs = [],
      key;

  for(key in tree.pkgdict){
    pkgs.push( tree.pkgdict[ key ] );
  }

  return pkgs;
}
