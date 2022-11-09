#!/usr/bin/env bash


function patch-status () {
  PATCH_DIR="$1"
  PATCH_FILE="$2"
  pushd "$PATCH_DIR" > "/dev/null" 2>&1
    
  if patch -NRp1 --dry-run < "$PATCH_FILE" > "/dev/null" 2>&1; then
    echo "on"
  elif patch -Np1 --dry-run < "$PATCH_FILE" > "/dev/null" 2>&1; then
    echo "off"
  else
    echo "unknown"
  fi
  popd > "/dev/null" 2>&1
}


function apply-patch () {
    PATCH_DIR="$1"
    PATCH_FILE="$2"
    echo
    echo "appling patch on dir: \"$PATCH_DIR\" patch: \"$PATCH_FILE\""
    pushd "$PATCH_DIR"
    patch -Np1 --forward < "$PATCH_FILE"
    # OUT="$(patch -p1 --forward < "$PATCH_FILE")" || echo "${OUT}" | grep "Skipping patch" -q || (echo "$OUT" && false);
    files=`git ls-files --others --exclude-standard | grep .orig$ || true`
    if [[ -n "${files}" ]]; then
        rm $files
    fi
    popd
}


function apply-patch2 () {
    PATCH_DIR="$1"
    PATCH_FILE="$2"
    PATCH_STATUS="${3:-on}"
    PATCH_STATE=`patch-status "$PATCH_DIR" "$PATCH_FILE"`
    
    PF="-Np1"
    echo ""
    if [[ "${PATCH_STATUS}" == "off" ]]; then
      PF="-NRp1"
    fi

    if [[ "${PATCH_STATE}" == "unknown" ]]; then
      echo "patch unknown error"
      return -1
    fi
    if [[ "${PATCH_STATE}" == "${PATCH_STATUS}" ]]; then
      echo "patch \"`basename $PATCH_FILE`\" already \"$PATCH_STATE\""
      return
    fi

    echo "patch \"`basename $PATCH_FILE`\": switch from $PATCH_STATE to $PATCH_STATUS"
    echo "appling patch on dir: \"$PATCH_DIR\" patch: \"`basename $PATCH_FILE`\""
    pushd "$PATCH_DIR"
    patch "$PF" < "$PATCH_FILE"
    # OUT="$(patch -p1 --forward < "$PATCH_FILE")" || echo "${OUT}" | grep "Skipping patch" -q || (echo "$OUT" && false);
    files=`git ls-files --others --exclude-standard | grep .orig$ || true`
    if [[ -n "${files}" ]]; then
        rm $files
    fi
    popd
}

function activate-folder () {
    FOLDER="$1"
    ACTIVATE_STATUS="${2:-on}"
    ACTIVATE_STATE="off"
    if [ -d "$FOLDER" ]; then
      ACTIVATE_STATE="on"
    fi

    if [[ "${ACTIVATE_STATUS}" == "${ACTIVATE_STATE}" ]]; then
      echo "folder \"`basename $FOLDER`\" already \"$ACTIVATE_STATE\""
      return
    fi
    if [[ "${ACTIVATE_STATUS}" == "on" ]]; then
      echo "sync folder: \"$FOLDER\""
      repo sync "$FOLDER"
    else # is 'off'
      echo "deleteing folder: \"$FOLDER\""
      rm -rf "$FOLDER"
    fi
}


function clean-repo () {
    PATCH_DIR="$1"
    echo
    echo "cleaning repo:\"$PATCH_DIR\""

    pushd "$PATCH_DIR"
    git checkout .
    git clean -fd
    popd
}

function activate-patch(){
  PATCH_DIR="$1"
  PATCH_FILE="$2"
  STATUS=`patch-status "$PATCH_DIR" "$PATCH_FILE"`
  if [[ "$(STATUS)" == "on" ]]; then
    echo "on"
  elif patch -Np1 --dry-run < "$PATCH_FILE" > "/dev/null" 2>&1; then
    echo "off"
  else
    echo "unknown"
  fi


}
