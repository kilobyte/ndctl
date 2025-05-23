#!/bin/bash -Ex
# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2025 Intel Corporation. All rights reserved.

. $(dirname "$0")/common

FEATURES="$TEST_PATH"/fwctl
rc=77
# 237 is -ENODEV
ERR_NODEV=237

trap 'err $LINENO' ERR

modprobe -r cxl_test
modprobe cxl_test

main()
{
   test -x "$FEATURES" || do_skip "no CXL Features Control"

    rc=0
    "$FEATURES" || rc=$?

    echo "status: $rc"
    if [ "$rc" -eq "$ERR_NODEV" ]; then
	do_skip "no CXL FWCTL char dev"
    elif [ "$rc" -ne 0 ]; then
	echo "fail: $LINENO" && exit 1
    fi

    _cxl_cleanup
}

{
    main "$@"; exit "$?"
}
