#!/bin/bash
SENSOR_ID=0
FRAMERATE=60
# bufapi enabled version

#GST_DEBUG=4
#gst-launch-1.0 nvarguscamerasrc sensor-id=$SENSOR_ID bufapi-version=1 ! m.sink_0 nvstreammux name=m batch-size=1 live-source=1 width=1920 height=1080 ! nvinfer config-file-path= samples/configs/deepstream-app/config_infer_primary.txt  ! queue ! nvmultistreamtiler width=1920 height=1080 ! nvvideoconvert ! nvdsosd ! udpsink auto-multicast=true port=5000 sync=false

#resnet only
GST_DEBUG=2 gst-launch-1.0 nvarguscamerasrc sensor-id=$SENSOR_ID bufapi-version=1 ! videoscale ! "video/x-raw(memory:NVMM),width=1920,height=540" ! m.sink_0 nvstreammux name=m batch-size=1 live-source=1 width=1920 height=540 ! nvinfer config-file-path= samples/configs/deepstream-app/config_infer_primary.txt  ! queue ! nvmultistreamtiler width=1920 height=540 ! nvvideoconvert ! nvdsosd ! nvegltransform ! nveglglessink sync=0
# optical flow + resnet
#GST_DEBUG=4 gst-launch-1.0 nvarguscamerasrc sensor-id=$SENSOR_ID bufapi-version=1 ! m.sink_0 nvstreammux name=m batch-size=1 live-source=1 width=1920 height=1080 ! nvinfer config-file-path= samples/configs/deepstream-app/config_infer_primary.txt  ! nvof ! tee name=t ! queue ! nvofvisual ! nvmultistreamtiler width=1920 height=1080 !  nvegltransform ! nveglglessink sync=0 t. ! queue ! nvmultistreamtiler width=1920 height=1080 ! nvvideoconvert ! nvdsosd ! nvegltransform ! nveglglessink sync=0
# bufapi + optical flow + resnet enabled version
#GST_DEBUG=4 gst-launch-1.0 nvarguscamerasrc sensor-id=$SENSOR_ID bufapi-version=1 ! m.sink_6 nvstreammux name=m batch-size=1 live-source=1 width=1280 height=720 ! nvvideoconvert ! nvdsosd ! nvegltransform ! nveglglessink sync=0


#sample_1080p_h264.mp4
#gst-launch-1.0 filesrc location = samples/streams/GX010063_smoothed.mp4 ! qtdemux ! h264parse ! nvv4l2decoder ! m.sink_0 nvstreammux name=m batch-size=1 width=1280 height=720 ! nvinfer config-file-path= samples/configs/deepstream-app/config_infer_primary.txt  ! nvof ! tee name=t ! queue ! nvofvisual ! nvmultistreamtiler width=1920 height=1080 !  nvegltransform ! nveglglessink sync=0 t. ! queue ! nvmultistreamtiler width=1920 height=1080 ! nvvideoconvert ! nvdsosd ! nvegltransform ! nveglglessink sync=0

#gst-launch-1.0 nvarguscamerasrc sensor-id=$SENSOR_ID ! "video/x-raw(memory:NVMM),width=1920,height=1080,framerate=$FRAMERATE/1" ! nvvidconv ! nvoverlaysink

#!  m.sink_0 nvstreammux name=m batch-size=1 width=1280 height=720 ! nvinfer config-file-path= samples/configs/deepstream-app/config_infer_primary.txt  ! nvof ! tee name=t ! queue ! nvofvisual ! nvmultistreamtiler width=1920 height=1080 !  nvegltransform ! nveglglessink sync=0 t. ! queue ! nvmultistreamtiler width=1920 height=1080 ! nvvideoconvert ! nvdsosd ! nvegltransform ! nveglglessink sync=0
