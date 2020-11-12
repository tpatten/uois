FROM nvidia/cuda:10.2-base-ubuntu18.04

ENV TZ=Europe/Vienna
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt-get update && \
    apt-get install -y sudo wget bash zip git rsync build-essential software-properties-common ca-certificates xvfb vim

RUN apt-get install -y python3.7-venv python3.7-dev python3-pip

RUN apt-get install -y libsm6 libxrender1 libfontconfig1 libpython3.7-dev libopenblas-dev

RUN python3.7 -m pip install numpy \
                             scipy \
                             matplotlib \
                             open3d \
                             tensorboardX \
                             future-fstrings \
                             easydict \
                             joblib \
                             scikit-learn \
                             jupyter \
                             Pillow \
                             pypng \
                             scikit-image \
                             scikit-build

RUN python3.7 -m pip install opencv-python==3.4.2.17

RUN python3.7 -m pip install torch==1.5.1 torchvision==0.6.1

# ==================================================================
# config & cleanup
# ------------------------------------------------------------------

RUN ldconfig && \
    apt-get clean && \
    apt-get autoremove && \
    rm -rf /var/lib/apt/lists/* /tmp/* ~/*

# nvidia-docker run -it -v /tmp/.X11-unix:/tmp/.X11-unix -v /home/tpatten:/home/tpatten -v /home/tpatten/v4rtemp:/home/tpatten/v4rtemp -e DISPLAY=$DISPLAY --env QT_X11_NO_MITSHM=1 -v /usr/lib/nvidia-450:/usr/lib/nvidia-450 -v /usr/lib32/nvidia-450:/usr/lib32/nvidia-450 -p 8888:8888 --privileged uois:latest bash
