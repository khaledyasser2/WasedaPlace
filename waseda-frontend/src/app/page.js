import Link from 'next/link';

export default function Home() {
  return (
    <div className="bg-white text-gray-900 font-sans">

    {/* Main Section */}
    <main className="flex flex-col items-center">
      <section className="flex flex-col md:flex-row items-center mt-10 md:space-x-10 px-6">
        <div className="md:w-1/2 text-center md:text-left mb-6 md:mb-0">
          <h1 className="text-5xl font-bold">Waseda Place</h1>
          <p className="text-4xl text-gray-400 mt-4 font-thin">Where rooms meet minds</p>
        </div>
        <img
          src="/images/hero.png"
          alt="A large lecture hall with many seats and a stage"
          className="rounded-lg md:w-1/2"
        />
      </section>

      {/* About Section */}
      <section className="bg-gray-100 w-full py-16 px-6 mt-10">
        <div className="max-w-3xl mx-auto text-center">
          <h2 className="text-4xl text-gray-400 mb-4 font-thin">About</h2>
          <p className="text-lg text-gray-600">
            Explore the rooms in Waseda that you would be able to book using this website
          </p>
        </div>
      </section>

      {/* Goals Section */}
      <section className="w-full py-16 px-6">
        <div className="max-w-5xl mx-auto text-center">
          <h2 className="text-3xl text-gray-400 mb-10 font-thin">Why Waseda Place / Our goals</h2>
          <div className="grid md:grid-cols-2 gap-10 text-left">
            <div className="flex items-start space-x-4">
              <div className="flex items-center h-full">
              <span className="text-8xl text-gray-200 mr-10 font-bold">1</span>
              <p className="text-lg text-gray-600">
                Whenever you miss the reservation for W-space, you can come to Waseda Place to find empty spots for your assignment.
              </p>
              </div>
            </div>
            <div className="flex items-start space-x-4">
              <div className="flex items-center h-full">
              <span className="text-8xl text-gray-200 mr-10 font-bold">2</span>
              <p className="text-lg text-gray-600">
                Our goal is to provide as many empty classrooms or lecture halls as possible so that students would be able to finish their work in the school facilities where they would be able to focus well.
              </p>
              </div>
            </div>
          </div>
        </div>
      </section>

      {/* Book Now Section */}
      <section className="my-10">
      <Link href="/booking" passHref>
        <button className="booking-button">Book Now</button>
      </Link>  
      </section>
    </main>
  </div>
  );
}
