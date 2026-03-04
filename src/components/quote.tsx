export default function Quote({ children }: { children: React.ReactNode }) {
    //return <div className="pl-5">{children}</div>;
    return <div className="px-5 italic [&_em]:not-italic">{children}</div>;
}