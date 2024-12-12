import AWS from "aws-sdk";

const s3 = new AWS.S3({
  region: process.env.AWS_S3_REGION,
  accessKeyId: process.env.AWS_S3_ACCESS_KEY,
  secretAccessKey: process.env.AWS_S3_SECRET_KEY,
});

const uploadS3 = async (stream, filePath, type) => {
  try {
    const params = {
      Bucket: process.env.AWS_S3_BUCKET,
      Key: filePath,
      Body: stream,
      ACL: "public-read",
      ContentType: type,
    };

    const uploadResult = await s3.upload(params).promise();
    // console.log("s3 업로드:", uploadResult);
  } catch (e) {
    console.log("s3 img upload error :", e);
  }
};

export default uploadS3;
