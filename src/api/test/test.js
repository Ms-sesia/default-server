export default {
  Mutation: {
    test: async (_, args, { request, isAutheticated }) => {
      const { text } = args;
      try {
        console.log("text:", text);

        return true;
      } catch (e) {
        console.log("test error:", e);
      }
    },
  },
};
