import React, { useEffect, useState } from 'react';
import useBaseUrl from '@docusaurus/useBaseUrl';

export default function VisitorCount() {
  const [stats, setStats] = useState(null);
  const jsonUrl = useBaseUrl('/visitor_count.json');

  useEffect(() => {
    fetch(jsonUrl)
      .then(res => res.json())
      .then(data => setStats(data))
      .catch(() => {});
  }, [jsonUrl]);

  if (!stats) return null;

    return (
    <div style={{ 
        textAlign: 'center',
        fontSize: '0.9rem',       // 0.8rem → 0.9rem 으로 키움
        color: 'var(--ifm-color-emphasis-500)',
        padding: '0 0 12px',   // 위 padding을 4px → 0 으로
        marginTop: '-26px',    // 위로 당기기
    }}>
    👁 어제 방문자: <strong>{stats.yesterday.toLocaleString()}</strong>
    &nbsp;|&nbsp;
    👥 총 방문자: <strong>{stats.total.toLocaleString()}</strong>
    </div>
  );
}