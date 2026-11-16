from pathlib import Path
from socket import gethostname

hostname = gethostname().split(".", 1)[0].lower()
conf_dir = Path(__file__).resolve().parent / "conf.d"
conf = conf_dir / f"{hostname}.conf"
if not conf.is_file():
    conf = conf_dir / "default.conf"

print(conf.read_text(), end="")
