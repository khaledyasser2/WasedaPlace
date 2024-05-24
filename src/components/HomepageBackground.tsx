import { FunctionComponent } from "react";
import styles from "./HomepageBackground.module.css";

const HomepageBackground: FunctionComponent = () => {
  return (
    <section className={styles.homepageBackground}>
      <div className={styles.reserveNowBtn}>
        <div className={styles.asiacultureCenterImage}>
          <div className={styles.whyWasedaPlace}>
            Why Waseda Place / Our goals
          </div>
        </div>
        <div className={styles.frame}>
          <div className={styles.missingReservationMessage}>
            <div className={styles.empty}>1</div>
          </div>
          <div className={styles.wasedaPlaceLogoWrapper}>
            <div className={styles.wasedaPlaceLogo}>
              <div className={styles.wheneverYouMiss}>
                Whenever you miss the reservation for W-space, you can come to
                Waseda Place to find empty spots for your kadai.
              </div>
              <div className={styles.wrapper}>
                <div className={styles.div}>2</div>
              </div>
            </div>
          </div>
          <div className={styles.ourGoalIs}>
            Our goal is to provide as many empty classrooms or lecture halls as
            possible so that students would be able to finish up their work in
            the school facilities where they would be able to focus well.
          </div>
        </div>
      </div>
    </section>
  );
};

export default HomepageBackground;
