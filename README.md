# snputil
matlab utility functions for GISTIC2 and related copy number repositories

## classes
### SegArray
A class for compressing arrays of segmented data (where values frequently repeat down columns). Defined by files in the @SegArray subdirectory.

### RefGeneInfo
A class defining the global RefGeneInfo object, allowing the transparent handling of non-human species without breaking legacy code. Defined in the file RefGeneInfo.m.
