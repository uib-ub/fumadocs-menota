export default function Size() {
    return (
        <div className='p-2 border rounded-xl h-15 w-15 content-center text-center font-bold'>
            <div className='block sm:hidden'>XS</div>
            <div className='hidden sm:block md:hidden'>SM</div>
            <div className='hidden md:block lg:hidden'>MD</div>
            <div className='hidden lg:block xl:hidden'>LG</div>
            <div className='hidden xl:block 2xl:hidden'>XL</div>
            <div className='hidden 2xl:block'>2XL</div>
        </div>
    )
}