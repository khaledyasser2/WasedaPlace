import { FunctionComponent } from "react";
import FrameComponent from "../components/FrameComponent";
import HomepageBackground from "../components/HomepageBackground";
import FrameComponent1 from "../components/FrameComponent1";
import styles from "./Homepage.module.css";

const Homepage: FunctionComponent = () => {
  return (
    <div className={styles.homepage}>
      <div className={styles.confirmationDialog}>
        <div className={styles.parent}>
          <img
            className={styles.icon}
            loading="lazy"
            alt=""
            src="/-20231212--151-3@2x.png"
          />
          <div className={styles.bookNowWrapper}>
            <div className={styles.bookNow}>Book Now</div>
          </div>
        </div>
      </div>
      <FrameComponent />
      <section className={styles.descriptionBox}>
        <div className={styles.exploreRooms}>
          <div className={styles.aboutWrapper}>
            <div className={styles.about}>About</div>
          </div>
          <div className={styles.exploreTheRooms}>
            Explore the rooms in Waseda that you would be able to book using
            this website
          </div>
        </div>
      </section>
      <HomepageBackground />
      <FrameComponent1 />
      <footer className={styles.wasedaLogo}>
        <b className={styles.wasedaplace}>@WasedaPlace</b>
      </footer>
    </div>
  );
};

export default Homepage;
