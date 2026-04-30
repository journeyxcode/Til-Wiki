import BlogPostPage from '@theme-original/BlogPostPage';
import GiscusComment from '@site/src/components/GiscusComment';

export default function BlogPostPageWrapper(props) {
  return (
    <>
      <BlogPostPage {...props} />
      <div style={{ maxWidth: '800px', margin: '0 auto', padding: '2rem' }}>
        <GiscusComment />
      </div>
    </>
  );
}