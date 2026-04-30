import Giscus from '@giscus/react';
import { useColorMode } from '@docusaurus/theme-common';

function GiscusCommentInner() {
  const { colorMode } = useColorMode();
  return (
    <Giscus
      repo="journeyxcode/ailog"
      repoId="R_kgDOSJnPfA"
      category="General"
      categoryId="DIC_kwDOSJnPfM4C8Dxh"
      mapping="pathname"
      strict="0"
      reactionsEnabled="1"
      emitMetadata="0"
      inputPosition="bottom"
      theme={colorMode === 'dark' ? 'dark_dimmed' : 'light'}
      lang="ko"
      loading="lazy"
    />
  );
}

export default function GiscusComment() {
  if (typeof window === 'undefined') return null;
  return <GiscusCommentInner />;
}