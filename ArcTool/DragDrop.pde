//https://qiita.com/rain-lotus/items/258fa3defd41846bfd50

import java.awt.datatransfer.*;  
import java.awt.dnd.*;  
import java.io.File;  
import java.io.IOException;  
import java.awt.Component;
import java.util.List;

DropTarget dropTarget;  
Component component;
File droppedFile;

void dragDropFile() {
  component = (Component)this.surface.getNative();

  dropTarget = new DropTarget(component, new DropTargetListener() {  
    public void dragEnter(DropTargetDragEvent dtde) {
    }  
    public void dragOver(DropTargetDragEvent dtde) {
    }  
    public void dropActionChanged(DropTargetDragEvent dtde) {
    }  
    public void dragExit(DropTargetEvent dte) {
    }  
    public void drop(DropTargetDropEvent dtde) {  
      dtde.acceptDrop(DnDConstants.ACTION_COPY_OR_MOVE);  
      Transferable trans = dtde.getTransferable();  
      List<File> fileNameList = null;  
      if (trans.isDataFlavorSupported(DataFlavor.javaFileListFlavor)) {  
        try {  
          fileNameList = (List<File>)  
            trans.getTransferData(DataFlavor.javaFileListFlavor);
        } 
        catch (UnsupportedFlavorException ex) {  
          println(ex);
        } 
        catch (IOException ex) {  
          println(ex);
        }
      }  
      if (fileNameList == null) return; 
      droppedFile=fileNameList.get(0);
    }
  }
  );
}
