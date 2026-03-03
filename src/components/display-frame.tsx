export default function DisplayFrame({ children }: { children: React.ReactNode }) {
    return <div className={`
        border 
        border-solid 
        rounded-lg 
        border-[#0669ff] 
        bg-[#ebf3ff]
        px-5
    `}>{children}</div>;
}