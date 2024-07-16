#!/bin/sh -e
echo "start tox install dependency"
pip install tox codecov

echo "start run auto check scripts"
tox -e py

cd ..

echo "start package starlineage"
python -m pip install --upgrade pip

pip install setuptools wheel

echo "start bdist_wheel"
python setup.py sdist bdist_wheel

echo "start upload package into pypi"
twine upload dist/*

echo "start clean up the project"
rm -rf .coverage* *.db build dist starlineage.egg-info || { echo "Cleanup failed"; exit 1; }
