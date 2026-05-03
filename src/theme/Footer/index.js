import React from 'react';
import Footer from '@theme-original/Footer';
import VisitorCount from '@site/src/components/VisitorCount';

export default function FooterWrapper(props) {
  return (
    <>
      <Footer {...props} />
      <VisitorCount />
    </>
  );
}