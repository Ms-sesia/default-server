export default {
  Query: {
    test: async (_, args, { request, isAutheticated, prisma }) => {
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
