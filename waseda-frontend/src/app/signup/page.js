"use client";  // Mark this component as a Client Component

import React, { useState } from 'react';
import { useRouter } from 'next/navigation';

export default function Signup() {
    const [email, setEmail] = useState('');
    const [name, setName] = useState('');
    const [isEmailValid, setIsEmailValid] = useState(false);
    const router = useRouter();

    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;


    // Check if email field is not empty
    const handleEmailChange = (e) => {
        const value = e.target.value;
        setEmail(value);
        setIsEmailValid(emailRegex.test(value.trim()));
    };

    // Handle form submission
    const handleReserveClick = () => {
        if (isEmailValid) {
            // Save data to local storage or another state management solution
            const formData = { email, name };
            localStorage.setItem('signupDetails', JSON.stringify(formData));

            // Redirect to the booking complete page
            router.push('/complete');
        } else {
            alert('Please enter a valid email address.');
        }
    };

    return (
        <div className="bg-[#f0f0f0] text-gray-900 font-sans">
            <div className="container mx-auto">
                <h1 className="title">Room Sign Up</h1>
                <form className="form">
                    <div className="inputGroup">
                        <input
                            type="email"
                            id="email"
                            name="email"
                            className="input"
                            placeholder="Email Address"
                            value={email}
                            onChange={handleEmailChange}
                        />
                        {!isEmailValid && email && (
                            <p className="text-red-500">Email is required.</p>
                        )}
                    </div>
                    <div className="inputGroup">
                        <input
                            type="text"
                            id="name"
                            name="name"
                            className="input"
                            placeholder="Name"
                            value={name}
                            onChange={(e) => setName(e.target.value)}
                        />
                    </div>
                </form>
                <button
                    className={`booking-button ${!isEmailValid ? 'opacity-60 cursor-not-allowed' : ''}`}
                    disabled={!isEmailValid}
                    onClick={handleReserveClick}
                >
                    Reserve
                </button>
            </div>
        </div>
    );
}
