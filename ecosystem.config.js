module.exports = {
  apps: [
    {
      name: "defaultServer",
      script: "./src/server-register.js",
      instances: 1,
      exec_mode: "cluster",
      watch: false,
      env: { NODE_ENV: "development" },
    },
    // {
    //   name: "cube_server_test",
    //   script: "./src/server-register_test.js",
    //   instances: 1,
    //   exec_mode: "cluster",
    //   watch: false,
    //   env: {
    //     NODE_ENV: "development",
    //   },
    // },
    {
      name: "prismaDB",
      script: "npm run studio",
      exec_mode: "fork",
      watch: false,
    },
  ],
};
