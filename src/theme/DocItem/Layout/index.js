import Layout from '@theme-original/DocItem/Layout';
import GiscusComment from '@site/src/components/GiscusComment';

export default function LayoutWrapper(props) {
  return (
    <>
      <Layout {...props} />
      <div style={{ 
        marginTop: '3rem', 
        padding: '0 1rem',
      }}>
        <GiscusComment />
      </div>
    </>
  );
}