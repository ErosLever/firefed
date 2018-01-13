SOURCE_DIR=firefed/

init:
	pip install pipenv --upgrade
	pipenv install --dev --skip-lock
test:
	pipenv run pytest -v --cov ${SOURCE_DIR} --cov-report term-missing:skip-covered tests/
testq: # Run tests quickly (outside pipenv and without long tests)
	pytest -m "not web and not slow" -v --cov ${SOURCE_DIR} --cov-report term-missing:skip-covered tests/
lint:
	pipenv run flake8
	pipenv run pylint --rcfile setup.cfg ${SOURCE_DIR}
codecov:
	pipenv run codecov
publish:
	rm -rf *.egg-info build/ dist/
	python setup.py bdist_wheel sdist
	twine upload -r pypi dist/*
	rm -rf *.egg-info build/ dist/
readme:
	python tools/make_readme.py
