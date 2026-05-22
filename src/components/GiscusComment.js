import BrowserOnly from '@docusaurus/BrowserOnly';
import Giscus from '@giscus/react';




// SSR 환경에서 useColorMode() 훅 오류를 방지하기 위해 Inner 컴포넌트로 분리
function GiscusCommentInner() {
  // useColorMode() 대신 HTML attribute로 다크모드 감지
  const isDark = document.documentElement.getAttribute('data-theme') === 'dark';

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
      theme={isDark === 'dark' ? 'dark_dimmed' : 'light'} /* 다크/라이트 모드에 따라 테마 자동 변경 */
      lang="ko"
      loading="lazy"
    />
  );
}

export default function GiscusComment() {
  return (
    // BrowserOnly: 클라이언트 사이드에서만 렌더링 → ColorModeProvider 마운트 이후 실행 보장
    <BrowserOnly fallback={<div />}>
      {() => <GiscusCommentInner />}
    </BrowserOnly>
  );
}