misskey-loading
        
    style.
        misskey-loading{
          width: 30px;
          height: 30px;
          margin: 90px 0;
          position: relative;
        }

        misskey-loading:before{
          position: absolute;
          left: 0;
          top: 0;
          right: 0;
          bottom: 0;
          background: rgba(192,192,192,0.5);
          content: "";
          border-radius: 50%;
          animation: anim1 2s infinite;
        }

        misskey-loading:after{
          position: absolute;
          left: 0;
          top: 0;
          right: 0;
          bottom: 0;
          background: rgba(192,192,192,0.5);
          content: "";
          border-radius: 50%;
          animation: anim1 2s -1s infinite;
        }

        @keyframes anim1{
            0%{transform: scale(0)}
           50%{transform: scale(2.5)}
          100%{transform: scale(0)}
        }
