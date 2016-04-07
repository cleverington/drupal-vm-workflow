module.exports = {
  options: {
    includePaths: ['<%= path.src %>/bower_components/foundation/scss']
  },
  dev: {
    files: {
      '<%= path.dist %>/css/overrides.css': '<%= path.src %>/scss/build/overrides.scss'
    }
  },
  dist: {
    files: {
      '<%= path.dist %>/css/overrides.css': '<%= path.src %>/scss/build/overrides.scss'
    }
  }
}
