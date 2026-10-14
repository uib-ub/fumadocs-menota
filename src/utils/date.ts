export function getEuroDate(date: Date): string {
    const s = date.toISOString();
    return `${s.substring(8, 10)}.${s.substring(5, 7)}.${s.substring(0, 4)}`;
}