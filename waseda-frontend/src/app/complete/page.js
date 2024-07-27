"use client";

import { useRouter } from 'next/navigation';
import { useEffect, useState } from 'react';

export default function BookingComplete() {
  const router = useRouter();
  const [bookingDetails, setBookingDetails] = useState(null);

  useEffect(() => {
    // Fetch booking details from local storage or a state management solution
    const storedDetails = JSON.parse(localStorage.getItem('bookingDetails'));
    
    if (storedDetails) {
      setBookingDetails(storedDetails);
    } else {
      router.push('/booking'); // Redirect to booking page if no details found
    }
  }, [router]);

  if (!bookingDetails) {
    return <p>Loading...</p>;
  }

  return (
    <div className="bg-white text-gray-900 font-sans">
    <main className="flex flex-col items-center p-8">
      <h1 className="text-4xl font-bold mb-6 text-center">Booking Complete</h1>
      <hr className="w-full border-gray-300 my-8" />
      <div className="booking-summary mt-12 text-center"> {/* Center-align text within this container */}
        <h2 className="text-2xl font-semibold mb-12">Booking Summary</h2>
        <ul className="list-disc list-inside space-y-6 mb-10 text-left mx-auto max-w-[80%]"> {/* Ensure list is left-aligned */}
          <li><strong>Purpose:</strong> {bookingDetails.purpose}</li>
          <li><strong>Building Number:</strong> {bookingDetails.buildingNumber}</li>
          <li><strong>Room:</strong> {bookingDetails.room}</li>
          <li><strong>Date:</strong> {bookingDetails.date}</li>
          <li><strong>Period:</strong> {bookingDetails.period}</li>
        </ul>
        <p className="text-lg mb-14">Email sent! Thank you for booking!</p>
      </div>
    </main>
  </div>
  );
}
