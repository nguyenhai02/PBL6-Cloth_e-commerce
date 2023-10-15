import { Carousel, Image } from "antd";
import React from "react";
import LazyLoad from "react-lazyload";
import "./Banner.scss";
const Banner = () => {
  return (
    <div>
      <Carousel dotPosition={"bottom"} autoplay>
        <div>
          <LazyLoad>
            <Image
              src="https://file.hstatic.net/200000018774/file/dsc00989_copy_86f6c86997424841878075fcac458f23.jpg"
              preview={false}
              title="collections"
            />
          </LazyLoad>
        </div>
        <div>
          <LazyLoad>
            <Image
              src="https://file.hstatic.net/200000018774/collection/dsc01063_copy_098bbc1d027345d283d0ff618270d423.jpg"
              preview={false}
              title="collections"
            />
          </LazyLoad>
        </div>
        <div> 
          <LazyLoad>
            <Image
              src="https://file.hstatic.net/200000018774/file/dsc01063_copy_af7d1cc6cf944ec9a32a230c7cda72ec.jpg"
              preview={false}
              title="collections"
            />
          </LazyLoad>
        </div>
      </Carousel>
    </div>
  );
};

export default Banner;
