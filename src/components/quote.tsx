export default function Quote({ straight, children }: { 
    straight?: boolean, 
    children: React.ReactNode 
}) {
    return <div className={`px-5 ${straight ? '' : 'italic [&_em]:not-italic'}`}>{children}</div>;
}