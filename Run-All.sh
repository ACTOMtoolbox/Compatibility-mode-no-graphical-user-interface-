echo '***************************************************'
echo '*                                                 *'
echo '*          Starting up the ACTOM Toolbox          *'
echo '*                   v1.0 2019-2022                *'
echo '*                                                 *'
echo '*        Re-Run using updated thresholds          *'
echo '*    and updated leakage rates in the ini file    *'
[ ! -d "'$(pwd)'/Advdiff" ] && [ ! -d "'$(pwd)'/Cseep" ] && [ ! -d "'$(pwd)'/ROC" ] && echo '*                                                 *'
[ ! -d "'$(pwd)'/Advdiff" ] && [ ! -d "'$(pwd)'/Cseep" ] && [ ! -d "'$(pwd)'/ROC" ] && echo '* Make sure you copy over the Advdiff, Cseep & ROC*'
[ ! -d "'$(pwd)'/Advdiff" ] && [ ! -d "'$(pwd)'/Cseep" ] && [ ! -d "'$(pwd)'/ROC" ] && echo '*      directories to the working directory:      *'
[ ! -d "'$(pwd)'/Advdiff" ] && [ ! -d "'$(pwd)'/Cseep" ] && [ ! -d "'$(pwd)'/ROC" ] && echo '*                                                 *'
[ ! -d "'$(pwd)'/Advdiff" ] && [ ! -d "'$(pwd)'/Cseep" ] && [ ! -d "'$(pwd)'/ROC" ] && echo '*  '$(pwd)'
[ ! -d "'$(pwd)'/Advdiff" ] && [ ! -d "'$(pwd)'/Cseep" ] && [ ! -d "'$(pwd)'/ROC" ] && echo '*          then press enter to continue           *'
[ ! -d "'$(pwd)'/Advdiff" ] && [ ! -d "'$(pwd)'/Cseep" ] && [ ! -d "'$(pwd)'/ROC" ] && read blankspace
echo '*                                                 *'
echo '***************************************************'
echo
echo '***************************************************'
echo '*              Deployment strategies              *'
echo '*                  Optimal Cover                  *'
echo '***************************************************'
echo
mkdir -p OptCover
cd OptCover
mkdir -p output
docker run -it $options \
          --mount type=bind,source="$(pwd)"/../Advdiff/output,target=/app/Input  \
          --mount type=bind,source="$(pwd)"/output,target=/app/Output \
          --mount type=bind,source="$(pwd)"/..,target=/external/settings \
 actomtoolbox/opt-cover-app
echo
echo '***************************************************'
echo '*              The Carbonate System               *'
echo '*                                                 *'
echo '***************************************************'
echo
mkdir -p ../carbon
cd ../carbon
mkdir -p output
docker run -it $options \
          --mount type=bind,source="$(pwd)"/../Advdiff/output,target=/external/input \
          --mount type=bind,source="$(pwd)"/output,target=/external/output \
          --mount type=bind,source="$(pwd)"/..,target=/external/settings \
 actomtoolbox/actom-co2
echo
echo '***************************************************'
echo '*                 Impact Analysis                 *'
echo '*                                                 *'
echo '***************************************************'
echo
mkdir -p ../impacts
cd ../impacts
mkdir -p output
docker run -it $options \
          --mount type=bind,source="$(pwd)"/../carbon/output,target=/external/input \
          --mount type=bind,source="$(pwd)"/..,target=/external/settings \
          --mount type=bind,source="$(pwd)"/output,target=/external/output \
 actomtoolbox/actom-impacts
echo
echo '***************************************************'
echo '*                 OUTPUT - Report                 *'
echo '*                                                 *'
echo '***************************************************'
echo
 cd ../
 docker run -it $options --mount type=bind,source="$(pwd)",target=/srv/actom-output/input actomtoolbox/actom-output
echo
echo '***************************************************'
echo '*     The Technical Summary can be found at:      *'
echo '*                                                 *'
echo '* file://'$(pwd)'/Technical-Summary.html'
echo '*                                                 *'
echo '*         with the full report found at:          *'
echo '*                                                 *'
echo '* file://'$(pwd)'/Report.html'
echo '*                                                 *'
echo '*          press Ctrl and click on link           *'
echo '*     or Copy url into your favourite browser     *'
echo '*                                                 *'
echo '***************************************************'
echo
