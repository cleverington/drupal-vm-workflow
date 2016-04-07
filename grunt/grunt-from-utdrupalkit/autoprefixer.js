module.exports = {
	dist: {
        expand: true,
        cwd: '<%= path.dist %>/css',
        src: [
          '**/*.css'
        ],
        dest: '<%= path.dist %>/css'
    },
    dev: {
        expand: true,
        cwd: '<%= path.dist %>/css',
        src: [
          '**/*.css'
        ],
        dest: '<%= path.dist %>/css'
    }
}