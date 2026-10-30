from setuptools import setup

setup(
    name='FastBinaryEncoding',
    version='1.0',
    packages=['proto'],
    package_dir={'': 'proto', 'proto': 'proto'},
    py_modules=['fbe'],
    python_requires='>=3.15',
    url='https://github.com/chronoxor/FastBinaryEncoding',
    license='MIT License',
    author='Ivan Shynkarenka',
    author_email='chronoxor@gmail.com',
    description='Fast Binary Encoding python project'
)
