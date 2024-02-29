# source this file from .profile to add sosh to the PATH

export SOSH="$(readlink -f "$(dirname "${BASH_SOURCE[0]}")")"
export PATH="$SOSH"/bin:"$PATH"
source "$SOSH"/sosh.bashrc

(
  echo --[ system solana cli ]----------------------------------------
  solana-install info --local
  solana -V

  echo --[ system summary ]--------------------------------------------
  (
    shopt -s nullglob
    export PS4="==> "
    set -x
    hc
    df -h . /mnt/{nvme*,tmpfs*}
    ded
    free -h
    uptime
  )

  (
    echo --[ sosh ]------------------------------------
    #shellcheck source=/dev/null
    . "$SOSH"/service-env.sh
    echo "$(solana --version): $(readlink -f ~/solana)"

    echo --[ $SOSH_CLUSTER config: $SOSH_CONFIG]-----------
    print-keys
  )
)
true
