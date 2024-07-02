export default function booking() {
    return (
      <div className="bg-white text-gray-900 font-sans">
      {/* Main Section */}
      <main className="flex flex-col items-center">
        <h1 className="text-4xl font-bold">Book Your Room</h1>
        <hr className="full-width-line"/>
  
        {/* Dropdown Menus */}
        <div className="dropdown-container">
          <select className="dropdown-menu">
            <option value="">Purpose</option>
            <option value="option1">Option 1</option>
            <option value="option2">Option 2</option>
          </select>
        </div>
        <div className="dropdown-container">
          <select className="dropdown-menu">
            <option value="">Building Number</option>
            <option value="option1">Option 1</option>
            <option value="option2">Option 2</option>
          </select>
        </div>
        <div className="dropdown-container">
          <select className="dropdown-menu">
            <option value="">Room</option>
            <option value="option1">Option 1</option>
            <option value="option2">Option 2</option>
          </select>
        </div>
        <div className="dropdown-container">
          <select className="dropdown-menu">
            <option value="">Time</option>
            <option value="option1">Option 1</option>
            <option value="option2">Option 2</option>
          </select>
        </div>

        {/* Book Room Button */}
        <button className="booking-button"  style={{ marginTop: '100px', marginBottom: '100px' }}>
          Book Now
        </button>
      </main>

    </div>
    );
  }