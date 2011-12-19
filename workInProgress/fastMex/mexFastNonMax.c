#include "mex.h"
#include "fast.h"

/* nlhs is num out. plhs is pointer to out.
  nrhs is num in. prhs is point to in. */
void mexFunction(int nlhs,mxArray *plhs[],int nrhs,const mxArray *prhs[]) {
 
    /* Get image data */
    int threshold = 50;
    int width = mxGetN(prhs[0]);
    int height = mxGetM(prhs[0]);
    int stride = height;
    unsigned char *img_data = mxGetData(prhs[0]);
 
    xy* corners;
    
    int dims1[1] = {1};
    plhs[1] = mxCreateNumericArray(1, dims1,mxINT32_CLASS,mxREAL);
    int *numCorners;
    numCorners = mxGetData(plhs[1]);
    corners = fast9_detect_nonmax(img_data, height, width, stride, threshold, numCorners);
    
    mexPrintf("Corners: %d\n",numCorners[0]);
   
    /* Create (temporary) output the array */
    int *output;
    int dims[2] = {2,*numCorners};
    plhs[0] = mxCreateNumericArray(2,dims,mxINT32_CLASS,mxREAL);
    output = mxGetData(plhs[0]);
        
    int j;
    for (j=0;j<*numCorners;j+=2){
        output[j]=corners[j/2].x;
        output[j+1] = corners[j/2].y;
    }
    
    

}

/* Note: stored in COL MAJOR ORDER. 
 * j+= height jumps down rows. */
    
