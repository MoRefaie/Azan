# -*- mode: python ; coding: utf-8 -*-

a = Analysis(
    ['AzanSchedular/azan_app.py'],
    pathex=[],
    binaries=[],
    datas=[
        ('AzanSchedular/*.py', '.'),
        ('AzanSchedular/.env', '.env'),
        ('AzanSchedular/config/*', 'config'),
        ('AzanSchedular/media/*', 'media'),
    ],
    hiddenimports=[
        'beautifulsoup4',
        'pyatv',
        'python-dotenv',
        'python_dateutil',
        'Requests',
        'tenacity',
        'fastapi',
        'uvicorn',
    ],
    hookspath=[],
    hooksconfig={},
    runtime_hooks=[],
    excludes=[],
    noarchive=False,
    optimize=0,
)

pyz = PYZ(a.pure)

exe = EXE(
    pyz,
    a.scripts,
    a.binaries,
    a.datas,
    [],
    name='AzanSchedular',
    debug=False,
    bootloader_ignore_signals=False,
    strip=False,
    upx=True,
    upx_exclude=[],
    runtime_tmpdir=None,
    console=True,
    disable_windowed_traceback=False,
    argv_emulation=False,
    target_arch=None,
    codesign_identity=None,
    entitlements_file=None,
)
