"use client";

import React, { useState } from 'react';

import { useRouter } from 'next/navigation';

export default function Booking() {
    const [purpose, setPurpose] = useState('');
    const [buildingNumber, setBuildingNumber] = useState('');
    const [room, setRoom] = useState('');
    const [date, setDate] = useState('');
    const [period, setPeriod] = useState('');
    

    // Function to check if all dropdowns have selections
    const isFormComplete = purpose && buildingNumber && room && date && period;

    const router = useRouter();

    const handleBooking = () => {
      const bookingDetails = { purpose, buildingNumber, room, date, period };
      localStorage.setItem('bookingDetails', JSON.stringify(bookingDetails));
      router.push('/signup');  // Redirect to booking complete page
  };

    return (
        <div className="bg-white text-gray-900 font-sans">
            {/* Main Section */}
            <main className="flex flex-col items-center">
                <h1 className="text-4xl font-bold">Book Your Room</h1>
                <hr className="full-width-line"/>

                {/* Dropdown Menus */}
                <div className="dropdown-container">
                    <select 
                        className="dropdown-menu" 
                        value={purpose} 
                        onChange={(e) => setPurpose(e.target.value)}
                    >
                        <option value="">Purpose</option>
                        <option value="Self Study">Self Study</option>
                        <option value="Quiet Study">Quiet Study</option>
                        <option value="Group Study">Group Study</option>
                        <option value="Interview">Interview</option>
                    </select>
                </div>
                <div className="dropdown-container">
                    <select 
                        className="dropdown-menu" 
                        value={buildingNumber} 
                        onChange={(e) => setBuildingNumber(e.target.value)}
                    >
                        <option value="">Building Number</option>
                        {[...Array(19).keys()].map(num => (
                            <option key={num+1} value={num+1}>{num+1}</option>
                        ))}
                    </select>
                </div>
                <div className="dropdown-container">
                    <select 
                        className="dropdown-menu" 
                        value={room} 
                        onChange={(e) => setRoom(e.target.value)}
                    >
                        <option value="">Room</option>
                        {[101, 102, 103, 104, 201, 202, 203, 204, 301, 302, 303, 304, 401, 402, 403, 404].map(num => (
                            <option key={num} value={num}>{num}</option>
                        ))}
                    </select>
                </div>
                <div className="dropdown-container">
                    <select 
                        className="dropdown-menu" 
                        value={date} 
                        onChange={(e) => setDate(e.target.value)}
                    >
                        <option value="">Date</option>
                        <option value="Monday">Monday</option>
                        <option value="Tuesday">Tuesday</option>
                        <option value="Wednesday">Wednesday</option>
                        <option value="Thursday">Thursday</option>
                        <option value="Friday">Friday</option>
                        <option value="Saturday">Saturday</option>
                    </select>
                </div>
                <div className="dropdown-container">
                    <select 
                        className="dropdown-menu" 
                        value={period} 
                        onChange={(e) => setPeriod(e.target.value)}
                    >
                        <option value="">Period</option>
                        {[1, 2, 3, 4, 5, 6, 7].map(num => (
                            <option key={num} value={num}>{num}</option>
                        ))}
                    </select>
                </div>
                {/* Book Room Button */}
                <button 
                    className={`booking-button ${!isFormComplete ? 'opacity-60 cursor-not-allowed' : ''}`}
                    style={{ marginTop: '100px', marginBottom: '100px' }}
                    disabled={!isFormComplete}  // Disable button if form is not complete
                    onClick={handleBooking}
                >
                    Book Now
                </button>
            </main>
        </div>
    );
}
