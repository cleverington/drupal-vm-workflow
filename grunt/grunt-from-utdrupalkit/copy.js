module.exports = {
      js: {
        files: [{
          expand: true,
          flatten: true,
          src: [],
          dest: '<%= path.dist %>/js'
        }]
      },
      STARTERKIT: {
        files: [
          // Stylesheets
          {
            expand: true,
            cwd: '<%= path.dist %>/css/',
            src: ['overrides.css'],
            dest: 'css'
          },
          // Scripts
          {
            expand: true,
            cwd: '<%= path.dist %>/js/',
            src: [],
            dest: 'js'
          }
        ]
      },
    }
