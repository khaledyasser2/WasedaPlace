export default function signup() {
    return (
    <div className="bg-white text-gray-900 font-sans">
      <div className="container">
        <h1 className="title">Room Sign Up</h1>
        <form className="form">
          <div className="inputGroup">
            <input
              type="email"
              id="email"
              name="email"
              className="input"
              placeholder="Email Address"
            />
          </div>
          <div className="inputGroup">
            <input
              type="text"
              id="name"
              name="name"
              className="input"
              placeholder="Name"
            />
          </div>
        </form>
        <button className="booking-button">Reserve</button>
      </div>
    </div>
    );
  }
  