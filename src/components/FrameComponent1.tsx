import { FunctionComponent } from "react";
import styles from "./FrameComponent1.module.css";

const FrameComponent1: FunctionComponent = () => {
  return (
    <section className={styles.homepageInner}>
      <div className={styles.bookNowWrapper}>
        <b className={styles.bookNow}>Book Now</b>
      </div>
    </section>
  );
};

export default FrameComponent1;
