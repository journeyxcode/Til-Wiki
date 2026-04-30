import clsx from 'clsx';
import Link from '@docusaurus/Link';
import useDocusaurusContext from '@docusaurus/useDocusaurusContext';
import Layout from '@theme/Layout';
import styles from './index.module.css';

const categories = [
  {
    emoji: '🤖',
    title: 'AI 기본기',
    desc: '수학/통계, ML, DL, NLP, LLM, Agent, RAG, Ops',
    link: '/ailog/docs/01-fundamentals/',
  },
  {
    emoji: '📰',
    title: '소식 & 논문',
    desc: 'AI 뉴스, 모바일 트렌드, 논문 리뷰',
    link: '/ailog/docs/02-news-papers/',
  },
  {
    emoji: '🖥️',
    title: '백엔드',
    desc: 'FastAPI, 데이터베이스, API 설계',
    link: '/ailog/docs/03-backend/',
  },
  {
    emoji: '🛠️',
    title: '도구',
    desc: 'AI 도구, 개발 환경, Git, Docusaurus',
    link: '/ailog/docs/04-tools/',
  },
  {
    emoji: '💼',
    title: '프로젝트',
    desc: '부트캠프 & 개인 프로젝트',
    link: '/ailog/docs/05-projects/',
  },
  {
    emoji: '📚',
    title: '기타',
    desc: '도서 리뷰, 강의 정리, 면접 준비',
    link: '/ailog/docs/06-etc/',
  },
];

const techStack = [
  { label: 'Python', color: '#3776ab' },
  { label: 'LangChain', color: '#1c7c54' },
  { label: 'LangGraph', color: '#1c7c54' },
  { label: 'Qdrant', color: '#dc244c' },
  { label: 'FastAPI', color: '#009688' },
  { label: 'Docker', color: '#2496ed' },
  { label: 'AWS', color: '#ff9900' },
  { label: 'W&B', color: '#ffbe00' },
  { label: 'Kotlin', color: '#7f52ff' },
  { label: 'Android', color: '#3ddc84' },
];

function HeroBanner() {
  return (
    <div className={styles.hero}>
      <div className={styles.heroInner}>
        <div className={styles.heroText}>
          <p className={styles.heroSub}>Android Developer → AI Engineer</p>
          <h1 className={styles.heroTitle}>
            배움과 공유를<br />
            할 줄 아는<br />
            <span className={styles.heroAccent}>AI 엔지니어</span>
          </h1>
          <p className={styles.heroDesc}>
            AI 엔지니어링 기술과 실무 경험을 정리한 기술 문서 공간입니다.<br />
            공부한 내용을 나만의 언어로 기록하고 공유합니다.
          </p>
          <div className={styles.heroBtns}>
            <Link className={styles.btnPrimary} to="/ailog/docs/intro">
              📖 문서 보기
            </Link>
            <Link className={styles.btnSecondary} to="/ailog/blog">
              ✍️ 블로그
            </Link>
            <Link
              className={styles.btnOutline}
              to="https://github.com/journeyxcode"
            >
              🐙 GitHub
            </Link>
          </div>
        </div>
        <div className={styles.heroImage}>
          <img src="/ailog/img/logo.png" alt="AI LOG" />
        </div>
      </div>
    </div>
  );
}

function CategoryCards() {
  return (
    <section className={styles.section}>
      <h2 className={styles.sectionTitle}>📂 다루는 내용</h2>
      <div className={styles.cardGrid}>
        {categories.map((cat) => (
          <Link key={cat.title} to={cat.link} className={styles.card}>
            <div className={styles.cardEmoji}>{cat.emoji}</div>
            <h3 className={styles.cardTitle}>{cat.title}</h3>
            <p className={styles.cardDesc}>{cat.desc}</p>
          </Link>
        ))}
      </div>
    </section>
  );
}

function TechStack() {
  return (
    <section className={styles.section}>
      <h2 className={styles.sectionTitle}>🛠️ 기술 스택</h2>
      <div className={styles.techGrid}>
        {techStack.map((tech) => (
          <span
            key={tech.label}
            className={styles.techBadge}
            style={{ borderColor: tech.color, color: tech.color }}
          >
            {tech.label}
          </span>
        ))}
      </div>
    </section>
  );
}

export default function Home() {
  const { siteConfig } = useDocusaurusContext();
  return (
    <Layout title="홈" description={siteConfig.tagline}>
      <main>
        <HeroBanner />
        <CategoryCards />
        <TechStack />
      </main>
    </Layout>
  );
}