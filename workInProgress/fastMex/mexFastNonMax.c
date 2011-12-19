#include "mex.h"
#include "fast.h"

/* nlhs is num out. plhs is pointer to out.
  nrhs is num in. prhs is point to in. */
void mexFunction(int nlhs,mxArray *plhs[],int nrhs,const mxArray *prhs[]) {
 
    /* Get image data */
    int width = mxGetN(prhs[0]);
    int height = mxGetM(prhs[0]);
    int stride = height;
    unsigned char *img_data = mxGetData(prhs[0]);
    int threshold = mxGetScalar(prhs[1]);
 
    xy* corners;
    
    int numCorners = 0;
    corners = fast9_detect_nonmax(img_data, height, width, stride, threshold, &numCorners);
    
    /* Create (temporary) output the array */
    int *output;
    int dims[2] = {2,numCorners};
    plhs[0] = mxCreateNumericArray(2,dims,mxINT32_CLASS,mxREAL);
    output = mxGetData(plhs[0]);
        
    int j;
    for (j=0;j<2*numCorners;j+=2){
        output[j]=corners[j/2].y;
        output[j+1] = corners[j/2].x;
    }
    
    mxFree(corners);

}

/* Note: stored in COL MAJOR ORDER. 
 * j+= height jumps down rows. */
    
