module.exports = function(grunt) {

  require('load-grunt-config')(grunt, {
    data: {
      path: {
        src: 'src',
        dist: 'dist',
        build: 'build'
      }
    }
  });

  return;
}
