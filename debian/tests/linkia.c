#include <daxctl/libdaxctl.h>
#include <ndctl/libndctl.h>
#include <cxl/libcxl.h>

int main()
{
    return daxctl_dev_get_id(0)
         + ndctl_dax_get_id(0)
         + cxl_memdev_get_pmem_size(0);
}
