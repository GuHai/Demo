<!DOCTYPE html">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0" />
	<title></title>
</head>
<body>


	<style>
		.test{width:50%;height:auto;overflow:hidden;text-align:left;margin:0.800rem auto;}
		.test>li{width:100%;height:1.067rem;}
		.test>li>a{width:100%;height:1.067rem;line-height:1.067rem;display:block;color:#333;font-size:0.427rem;}
	</style>
	<ul class="test">
<?php
 function read_all_dir ( $dir )
    {
        $result = array();
        $handle = opendir($dir);
        if ( $handle )
        {
            while ( ( $file = readdir ( $handle ) ) !== false )
            {
                if ( $file != '.' && $file != '..')
                {
                    $cur_path = $dir . DIRECTORY_SEPARATOR . $file;
                    if ( is_dir ( $cur_path ) )
                    {
                        $result['dir'][$cur_path] = read_all_dir ( $cur_path );
                    }
                    else
                    {
                        $result['file'][] = $cur_path;
                    }
                }
            }
            closedir($handle);
        }
        return $result;
    }
	
	$path = str_replace("index.php","",__FILE__) ;
	$fileArr = read_all_dir($path);
	foreach ($fileArr['file'] as $k => $v) {
		$v = mb_convert_encoding($v, "UTF-8", "GBK"); 
		$file = str_replace($path.'\\',"",$v);
		echo '<li><a href="'.$file.'">'.$file.'</a></li>';
	}
?>
	</ul>
	
</body>
</html>