import './globals.css';
import { Inter } from 'next/font/google';

const inter = Inter({ subsets: ['latin'] });

export const metadata = {
  title: 'Hệ thống Quản lý Giải Đua Ngựa',
  description: 'Quản lý giải đua ngựa chuyên nghiệp - Java course project',
};

export default function RootLayout({
  children,
}: {
  children: React.ReactNode;
}) {
  return (
    <html lang="vi">
      <body className={`${inter.className} bg-slate-900 text-slate-100 min-h-screen`}>
        {children}
      </body>
    </html>
  );
}
