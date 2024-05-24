import { FunctionComponent } from "react";
import styles from "./FrameComponent.module.css";

const FrameComponent: FunctionComponent = () => {
  return (
    <section className={styles.lateReservationMsgWrapper}>
      <div className={styles.lateReservationMsg}>
        <img
          className={styles.asiaCulturecenterCowf5ztz6wIcon}
          loading="lazy"
          alt=""
          src="/asiaculturecentercowf5ztz6wunsplash-1@2x.png"
        />
        <div className={styles.frameWrapper}>
          <div className={styles.frame}>
            <div className={styles.wasedaPlaceWhereContainer}>
              <span className={styles.wasedaPlaceWhereContainer1}>
                <p className={styles.wasedaPlace}>
                  <b>Waseda Place </b>
                </p>
                <p className={styles.whereRoomsMeet}>Where rooms meet minds</p>
              </span>
            </div>
          </div>
        </div>
      </div>
    </section>
  );
};

export default FrameComponent;
