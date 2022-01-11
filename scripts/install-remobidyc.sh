#!/bin/bash
mkdir remobidyc
cd remobidyc
curl -L https://get.pharo.org/64/90+vm | bash
./pharo Pharo.image metacello install github://ReMobidyc/ReMobidyc:main BaselineOfReMobidyc
cat <<EOF > remobidyc
#!/bin/bash
cd \$(dirname \$0)
./pharo-ui Pharo.image
EOF
chmod a+rx remobidyc
echo "install done. please add "$PWD" to your PATH env var."
